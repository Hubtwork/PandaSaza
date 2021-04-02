var express = require('express');
var router = express.Router();

var _ = require('lodash')

var userData= require('../data/user-data')
var userProfile = require('../data/user-profiles')

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/signIn', function(req, res, next) {
  var id = req.query.id
  var pw = req.query.pw

  


})

module.exports = router;
