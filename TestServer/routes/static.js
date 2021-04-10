var express = require('express')
var router = express.Router()
var _ = require('lodash')

var schoolData = require('../data/school')

router.get('/schools', function(req, res, next) {
    res.json(schoolData)
})
  


module.exports = router