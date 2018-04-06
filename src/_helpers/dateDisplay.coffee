format = require 'date-fns/format'
locales = require 'date-fns/locale/de'

module.exports = (date, formatStr) -> format date, formatStr, locale: locales
