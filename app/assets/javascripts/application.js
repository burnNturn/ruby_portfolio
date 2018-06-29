// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui
//= require_tree .


$(document).ready(function(){
    $('#symbol-search-field').on('input', function(){
        var sym = $('#symbol-search-field').val();
        
        
        var search = $.ajax({
            url: 'securities/search',
            type: 'GET',
            data: { symbol: sym} 
        });
    });
});

function getAbsolutePath() {
    var pathArray = window.location.pathname.split( '/' );
    return pathArray[pathArray.length -1]
    
    // var loc = window.location;
    // var pathName = loc.pathname.substring(0, loc.pathname.lastIndexOf('/') + 1);
    // return loc.href.substring(0, loc.href.length - ((loc.pathname + loc.search + loc.hash).length - pathName.length));
}
