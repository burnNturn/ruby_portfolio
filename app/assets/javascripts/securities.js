$(document).ready(function() {
    var security = getAbsolutePath();
    $ajax({
        url: 'securities/institutional_holders',
        type: 'get',
        data: { security }
    })
});

function getAbsolutePath() {
    var loc = window.location;
    var pathName = loc.pathname.substring(0, loc.pathname.lastIndexOf('/') + 1);
    return loc.href.substring(0, loc.href.length - ((loc.pathname + loc.search + loc.hash).length - pathName.length));
};