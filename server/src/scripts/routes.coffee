
# home page
exports.index = (req, res) ->
    res.render 'home', {title: "Happ"}

# support page
exports.support = (req, res) ->
	res.render 'support'

# terms
exports.terms = (req, res) ->
	res.render 'terms'