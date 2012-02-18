define(['order!jquery', 'order!jquery-ujs', 'order!bootstrap'], function ($, _) {
    $(function () {

        // If we come into the page with a hash:
        if (window.location.hash) {
            updateFromHash();
        }

        // If the browser supports the 'hashchange' event:
        if ('onhashchange' in window) {
            $(window).bind('hashchange', updateFromHash);
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
});