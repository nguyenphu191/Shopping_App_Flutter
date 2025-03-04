const mongoose = require('mongoose');

productSchema = new mongoose.Schema({
    id: { type: String, required: true, unique: true },
    SellerID: { type: String, required: true },
    name: { type: String, required: true },
    description: { type: String, required: true },
    sold: { type: Number, required: true },
    address: { type: mongoose.Schema.Types.Mixed },
    imgs: {type: mongoose.Schema.Types.Mixed},
    colors: {type: mongoose.Schema.Types.Mixed, required: true},
    sizes: {type: mongoose.Schema.Types.Mixed, required: true},
    category: { type: String, required: true },
    rating: { type: Number, required: true },
    numberrate: { type: Number, required: true },
    variants: { type: mongoose.Schema.Types.Mixed },

});
const Product = mongoose.model("Product", productSchema);
module.exports = Product;