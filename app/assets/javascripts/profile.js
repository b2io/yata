// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/2.0.1/bootstrap
//= require getsatisfaction/feedback-v2

$(function () {

    // If we come into the page with a hash:
    if (window.location.hash) {
        updateFromHash();
    }

    // If the browser supports the 'hashchange' event:
    if ('onhashchange' in window) {
        $(window).on('hashchange', updateFromHash);
    }

    function updateFromHash() {
        // Find the nav-tab with the right href; click it.
        $(".nav.nav-tabs li a[href='#" + window.location.hash.substr(2) + "']").click();
    }

    // Listen for tabs to be shown:
    $('a[data-toggle="tab"]').on('shown', function (e) {
        // Stop the default behavior.
        e.preventDefault();

        // Reroute the hash to one of our choosing.
        var href = $(e.currentTarget).attr('href').substr(1);
        window.location.hash = "/" + href;
    });

    // Listen for clicks on links intended to delete linked-accounts:
    $('a[data-unlink]').on('click', function (e) {
        var el = $('#confirm-unlink a.btn-danger');
        el.attr('href', "/authorizations/" + $(e.currentTarget).data('unlink'));
    });

});