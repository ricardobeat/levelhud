db = window.db = {}
ws = null

methods = [
    'get'
    'put'
    'del'
    'createReadStream'
    'createKeyStream'
    'createValueStream'
]

request = (method, args...) ->
    console.log 'Sending command', method, args
    app.clear()
    ws.send { method, args }

for method in methods
    db[method] = request.bind null, method

do connect = ->
    ws = new WebSocket "ws://#{window.location.host}"
    ws._send = ws.send
    ws.send = (message) -> ws._send JSON.stringify message

    ws.onopen = ->
        new Notification().render("Connection established")

    ws.onmessage = (res) ->
        return unless try data = JSON.parse res.data
        if data.message
            new Notification().render(data.message)
        if data.key or data.value
            app.results.add data

    ws.onclose = ->
        new Notification({ error: true }).render("Connection lost")
        setTimeout connect, 1000 * 5

# -----------------------------------------------------------------------------

_.templateSettings =
  evaluate    : /\{\{(.+?)\}\}/g  # {{if (x) ... }}
  interpolate : /\{\{=(.+?)\}\}/g # {{=var}}

Backbone.View::renderTemplate = (data) ->
    @$el.html @template(data)

# -----------------------------------------------------------------------------

QueryView = Backbone.View.extend
    el: '#query'
    events:
        'click .run': 'submitQuery'
        'keydown .command input': 'checkReturn'
    initialize: ->
        # ugh
        $('#presets').on 'click', 'a', (e) =>
            e.preventDefault()
            self = $(e.target)
            cmd = self.text()
            @$el.find('.command input').val(cmd).focus()
            self.closest('.f-dropdown').removeAttr('style').removeClass('open')

    checkReturn: (e) ->
        if e.keyCode is 13 then @submitQuery()

    submitQuery: (e) ->
        e?.preventDefault()
        q = @$el.find('.command input').val()
        unless q.indexOf('db.') is 0
            new Notification({ error: true }).render("Invalid command.")
            return
        setTimeout(q, 0)

# -----------------------------------------------------------------------------

Notification = Backbone.View.extend
    initialize: (options) ->
        className = if options?.error then 'alert-box alert' else 'alert-box'
        @$el.attr('class', className)
        setTimeout @remove.bind(this), 2000
    events:
        'click': 'remove'
    render: (text) ->
        @$el.text(text)
        @$el.appendTo(app.queryView.el)

# -----------------------------------------------------------------------------

Row = Backbone.Model.extend
    initialize: ->
        value = this.get('value')
        this.set('key', JSON.stringify this.get('key'))
        this.set('value', JSON.stringify value, null, 2)
        this.set('short', JSON.stringify value)

Results = Backbone.Collection.extend
    model: Row

RowView = Backbone.View.extend
    tagName: 'tr'
    template: _.template $('#row-template').text()
    events:
        'click': 'toggle'
    toggle: ->
        this.short = !this.short
        @render()
    render: ->
        key   = this.model.get('key')
        value = this.model.get('value')
        short = this.model.get('short')
        if !@short
            if key?.length > 45 then key = key.slice(0, 45) + '...'
            if value?.length > 70 then value = short.slice(0, 70) + '...'
        @renderTemplate {
            key   : _.escape key
            value : _.escape value
        }

ResultsView = Backbone.View.extend
    el: '#results tbody'
    initialize: ->
        @listenTo app.results, 'add', (item) ->
            row = new RowView { model: item }
            row.render()
            @$el.append(row.el)

    render: ->

# -----------------------------------------------------------------------------

window.app =
    init: ->
        @results     = new Results
        @resultsView = new ResultsView
        @queryView   = new QueryView

    clear: ->
        @resultsView.$el.empty()
