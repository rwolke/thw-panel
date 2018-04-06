path = require "path"
webpack = require "webpack"
fs = require "fs"

HtmlWebpackPlugin = require 'html-webpack-plugin'
ExtractTextPlugin = require "extract-text-webpack-plugin"
CompressionPlugin = require "compression-webpack-plugin"

extractCSS = new ExtractTextPlugin 
	filename: "css/[name].css"

plugins = []
plugins.push new webpack.ProvidePlugin
	$: "jquery"
	jQuery: "jquery"
	Popper: ['popper.js', 'default']
#	Alert: "exports-loader?Alert!bootstrap/js/dist/alert"
#	Button: "exports-loader?Button!bootstrap/js/dist/button"
#	Carousel: "exports-loader?Carousel!bootstrap/js/dist/carousel"
#	Collapse: "exports-loader?Collapse!bootstrap/js/dist/collapse"
#	Dropdown: "exports-loader?Dropdown!bootstrap/js/dist/dropdown"
#	Modal: "exports-loader?Modal!bootstrap/js/dist/modal"
#	Popover: "exports-loader?Popover!bootstrap/js/dist/popover"
#	Scrollspy: "exports-loader?Scrollspy!bootstrap/js/dist/scrollspy"
#	Tab: "exports-loader?Tab!bootstrap/js/dist/tab"
#	Tooltip: "exports-loader?Tooltip!bootstrap/js/dist/tooltip"
	Util: "exports-loader?Util!bootstrap/js/dist/util"
#	THREE: "THREE"

plugins.push new webpack.optimize.CommonsChunkPlugin 
	name: "lib" 
	filename: "js/lib.js"

plugins.push extractCSS

plugins.push new HtmlWebpackPlugin
	filename: "index.html"
	title: "Cards"
	settings: JSON.stringify JSON.parse fs.readFileSync "src/settings.json"
	template: 'src/templates/index.hbs'

rules = []
# csv
rules.push
	test: /\.csv$/,
	use: [
			loader: "dsv-loader"
	]
# coffescript
rules.push
	test: /\.coffee$/, 
	use: [
			loader: "coffeescript-loader"
			options:
				sourceMap: true 
	]

# css
rules.push
	test: /\.css$/
	use: extractCSS.extract
		use: [
				loader: "css-loader", 
				options:
					importLoaders: 2
					minimize: true
					sourceMap: true 
		]

#scssless
rules.push
	test: /\.(scss)$/,
	use: extractCSS.extract
		use: [
			loader: 'css-loader'
		,
			loader: 'sass-loader'
		]

# font woff
rules.push
	test: /\.woff(\d+)?(\?\d*)?$/
	use: [
			loader: "url-loader"
			options:
				name: "font/[name].[ext]"
				limit: 5000
				mimetype: "application/font-woff"
	]

# stylus
rules.push
	test: /\.styl$/
	use: extractCSS.extract 
		use: [
				loader: "css-loader", 
				options:
					sourceMap: true 
					importLoaders: 2
			,
				loader: "postcss-loader"
				options:
					sourceMap: true 
					plugins: => [
						require('autoprefixer')({browsers: ['last 2 versions', '> 5%']})
					]
			,
				loader: 'stylus-loader'
				options:
					sourceMap: true 
#					paths: ["#{cfg.src}/style/inc","#{cfg.src}/_cfg"]
		]

#handlebars precompile
rules.push
	test: /\.hbs$/, 
	use: [
			loader: "handlebars-loader", 
			options:
				helperDirs: ["#{__dirname}/src/_helpers/handlebars"]
				knownHelpers: ['cmp.js']
	]

rules.push
	enforce: 'pre'
# http://stackoverflow.com/questions/35877475/trying-to-require-parts-of-jquery-with-webpack
	test: /jquery[\\\/]src[\\\/]selector-sizzle\.js$/,
	loader: 'string-replace-loader',
	query:
		search: '../external/sizzle/dist/sizzle',
		replace: 'sizzle'

# json loader
rules.push
	test: /\.json$/, 
	use: [
			loader: "json-loader"
	]

module.exports = (env) -> 
	cache: true
	devtool: 'source-map'
	entry:
		app: "app"
		lib: [
			"jquery"
			"jspdf"
			"bootstrap"
			"bootstrap/scss/bootstrap.scss"
			"backbone"
			"style"
		]
	
	output: 
		path: "#{__dirname}/docs"
		publicPath: ""
		filename: "js/[name].js"
	
	externals:
		App: 'app',
		window: 'window'
	
	module:
		rules: rules
	
	resolve:
		alias:
			jquery: "jquery/src/jquery"
		modules: [
			"src"
			"src/_helpers"
			"data"
			"style"
			"node_modules"
		]
		extensions: [".js", ".coffee", ".hbs", ".styl", ".css"]
	
	plugins: plugins
	
	devServer:
		headers: 
			"Access-Control-Allow-Origin": "*"
		contentBase: "."
#		historyApiFallback: true
