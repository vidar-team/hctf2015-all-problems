$(document).ready(function () {
    console.error('开发中。。。');

    $('#clearcart').click(function () {
        $.get('clearcart.php', function(data) {
            $('#cart-result').html(data);
            location.reload(true);
        });
    });

    $('#buycart').click(function () {
        $.get('buycart.php', function(data) {
            $('#cart-result').html(data);
            location.reload(true);
        });
    });
});