$(document).ready(function() {
    $('#game-mode').on('change', function() {
        $.ajax({
          url: $(this).data('url'),
          data: { 
            new_game_mode: $(this).val(),
            player_id: $(this).data('player-id')
          },
          dataType: 'script',
          method: 'GET'
        });
    });
});