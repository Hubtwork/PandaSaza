var express = require('express')
var productData = require('../data/product-list')
var productDetail = require('../data/product-detail')
var categoryData = require('../data/category')
var router = express.Router()
var _ = require('lodash')

var products = productData
var category = categoryData
var productDetails = productDetail

router.get('/products', function(req, res, next) {
    // Change Category Id to Category String 
    console.log("All Products")
    products.forEach(function(data){
        data.itemCategory = _.find(category, function(object) { return object.id == data.itemCategory }).categoryStr
        }
    )
    res.json(products)
});

router.get('/:id', function(req, res, next) {
    console.log("ID : " + req.params.id)
    var product = _.find(productDetails, function(object) { return object.itemId == req.params.id })
    product.itemCategory = _.find(category, function(object) { return object.id == product.itemCategory }).categoryStr
    res.json(product || {})
})

router.get('/category/:category', function(req, res, next) {
    console.log("Category : " + req.params.category)
    var categoryStr = _.find(category, function(object) { return object.id == req.params.cateogry }).categoryStr
    var filtered_products = _.find(products, function(object) { return object.itemCategory == req.params.category })
    filtered_products.forEach(function(data) {
        data.itemCategory = categoryStr
    })
    res.json(filtered_products)
})
  
module.exports = router;
  