document.addEventListener('DOMContentLoaded', () => {
  const counterElement = document.getElementById('count');
  const api = 'https://4z459frbmh.execute-api.us-west-1.amazonaws.com/prod';
  updateVisit();

  function updateVisit(){
    fetch(api)
      .then((response) => response.json())
      .then((response) => { counterElement.innerHTML = response;});
  }
});
