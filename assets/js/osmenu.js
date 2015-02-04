$(document).ready(function(){
  $('#operatingSystems').change(function() {
    switch($(this).val()) {
      case "rhel6":
        $('#rhel6').show();
        $('#rhel7').hide();
        $('#el6').show();
        $('#el7').hide();
      break;
      case "rhel7":
        $('#rhel6').hide();
        $('#rhel7').show();
        $('#el6').hide();
        $('#el7').show();
      break;
      case "el6":
        $('#rhel6').hide();
        $('#rhel7').hide();
        $('#el6').show();
        $('#el7').hide();
        break;
      case "el7":
        $('#rhel6').hide();
        $('#rhel7').hide();
        $('#el6').hide();
        $('#el7').show();
        break;
    }
  });
});
