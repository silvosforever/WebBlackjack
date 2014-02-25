$(document).ready(function() {
  player_hits();
  player_stays();
  dealer_hit();
});

function player_hits() {
  $(document).on('click', '#hit_form input', function() {
    $.ajax({
      type: 'POST',
      url: '/game/player/hit'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });
}

function player_stays() {
  $(document).on('click', '#stay_form input', function() {
    $.ajax({
      type: 'POST',
      url: '/game/player/stay'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });
}

function dealer_hit() {
  $(document).on('click', '#hit_dealer_form input', function() {
    $.ajax({
      type: 'POST',
      url: '/game/dealer/hit'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });
}