$("#<%= dom_id(@reply) %>").slideUp("normal").promise().done(function() {
    $(this).remove();
});