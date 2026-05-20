
document.getElementById('curlForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const key = document.getElementById('key').value;
    const value = document.getElementById('value').value;
    const url = document.getElementById('url').value;

    const data = new FormData();
    data.append('url', url);
    data.append(`data[${key}]`, value);

    fetch(window.location.href, {
        method: 'POST',
        body: data,
    });
});
