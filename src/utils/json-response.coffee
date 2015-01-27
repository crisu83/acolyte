class JsonResponse
  constructor: (data) ->
    @data = data or {}

  add: (key, value) ->
    @data[key] = value

  success: () ->
    json =
      success: true
      data: @data
    json

  error: (error) ->
    json =
      success: false
      error: error or "Unknown error"
      data: @data
    json

module.exports = JsonResponse
