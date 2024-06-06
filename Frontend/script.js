const ip = window.location.hostname;
const url = "http://" + ip + ":5000/news";

document.addEventListener('DOMContentLoaded', function() {
  fetch(url)
    .then(response => response.json())
    .then(data => {
      const newsContainer = document.getElementById('news-container');
      data.slice(0, 10).forEach(news => {
        const newsItem = document.createElement('div');
        newsItem.classList.add('news-item');
        
        const newsTitle = document.createElement('div');
        newsTitle.classList.add('news-title');
        newsTitle.textContent = news.title;
        
        const newsTimestamp = document.createElement('div');
        newsTimestamp.classList.add('news-timestamp');
        newsTimestamp.textContent = new Date(news.timestamp).toLocaleString();
        
        const newsContent = document.createElement('div');
        newsContent.classList.add('news-content');
        newsContent.textContent = news.content;
        
        newsItem.appendChild(newsTitle);
        newsItem.appendChild(newsTimestamp);
        newsItem.appendChild(newsContent);
        
        newsContainer.appendChild(newsItem);
      });
    })
    .catch(error => console.error('Error fetching news:', error));
});