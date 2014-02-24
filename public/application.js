$(document).ready(function() {

  $(document).on('click', '#hit_form input', function() {
    $.ajax({
      type: 'POST',
      url: '/game/player/hit'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', '#stay_form input', function() {
    $.ajax({
      type: 'POST',
      url: '/game/player/stay'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', '#hit_dealer_form input', function() {
    $.ajax({
      type: 'POST',
      url: '/game/dealer/hit'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', '#replay_form input', function() {
    $.ajax({
      type: 'GET',
      url: '/bet'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', '#end_form input', function() {
    $.ajax({
      type: 'GET',
      url: '/end'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', '#kicked_form input', function() {
    $.ajax({
      type: 'GET',
      url: '/end'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', '#bet_form input.button', function() {
    $.ajax({
      type: 'POST',
      url: '/bet'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', '#start_over_form input', function() {
    $.ajax({
      type: 'GET',
      url: '/new_player'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });

  $(document).on('click', '#new_player_form input.button', function() {
    $.ajax({
      type: 'POST',
      url: '/new_player'
    }).done(function(msg) {
      $('#template').replaceWith(msg);
    });
    return false;
  });
});