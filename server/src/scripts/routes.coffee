
# home page
exports.index = (req, res) ->
    res.render 'home', {title: "Happ"}

# support page
exports.support = (req, res) ->
	res.render 'support', {title: "Happ | Support"}

# terms
exports.terms = (req, res) ->
	res.render 'terms', {title: "Happ | Terms of Service"}