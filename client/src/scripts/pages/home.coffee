
$ ->
    
    console.log 'here';

    window.happ = window.happ || {};

    happ.effects = {
    	enter_left : ($elem, start, stop) ->
    		@$elem	= $elem
    		@current= start
    		@stop	= stop

    		window.setInterval ->
    			@current += 1
    			@$elem.css 'margin-left', @current
    			if @current >= @stop
    				window.clearInterval
    		,	10
    			
    }

