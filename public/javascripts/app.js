$(function() {
  $("#test-button").click(function() {
    $.post('/echo', $("#lead-form").serialize(), function(response) {
      $("#json").html(response);
      $("#json-container").show();
    });
    return false;
  });

  $("#json-container .close").click(function() {
    $("#json-container").hide();
  });
});
