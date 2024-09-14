document.addEventListener('DOMContentLoaded', () => {
  const counterElement = document.getElementById('count');
  const api = 'https://fgotxd2dda.execute-api.us-west-1.amazonaws.com/lambda_counter';
  updateVisit();

  function updateVisit(){
    fetch(api, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    })
    .then((response) => response.json())
    .then((response) => { counterElement.innerHTML = response; })
    .catch((error) => { console.error('Error:', error); });
  }
});