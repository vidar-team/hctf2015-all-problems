$(document).ready(function () {
    $('#server-a').click(function () {
        $.post("ajax-cart.php", {p:'a'}, function (data) {
           $('#add-result').html(data);
           location.reload(true);
        });
    });

    $('#server-b').click(function () {
        $.post("ajax-cart.php", {p:'b'}, function (data) {
            $('#add-result').html(data);
            location.reload(true);
        });
    });

    $('#server-c').click(function () {
        $.post("ajax-cart.php", {p:'c'}, function (data) {
            $('#add-result').html(data);
            location.reload(true);
        });
    });

    $('#server-d').click(function () {
        $.post("ajax-cart.php", {p:'d'}, function (data) {
            $('#add-result').html(data);
            location.reload(true);
        });
    });

    $('#server-e').click(function () {
        $.post("ajax-cart.php", {p:'e'}, function (data) {
            $('#add-result').html(data);
            location.reload(true);
        });
    });

    $('#server-f').click(function () {
        $.post("ajax-cart.php", {p:'f'}, function (data) {
            $('#add-result').html(data);
            location.reload(true);
        });
    });
});