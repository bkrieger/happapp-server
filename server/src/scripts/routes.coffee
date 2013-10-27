
# home page
exports.index = (req, res) ->
    res.render 'home', {title: "Happ"}

# support page
export.support = (req, res) ->
	res.render 'support'

# terms
export.terms = (req, res) ->
	res.render 'terms'