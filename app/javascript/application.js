// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


//= require bootstrap
// app/assets/javascripts/application.js

document.addEventListener('DOMContentLoaded', function() {
    const userSearchInput = document.querySelector('#search');
    const userList = document.querySelector('#user-list');
  
    userSearchInput.addEventListener('input', function() {
      const searchQuery = userSearchInput.value.toLowerCase();
      const users = document.querySelectorAll('.card');
  
      users.forEach(function(user) {
        const userName = user.querySelector('.card-body').textContent.toLowerCase();
  
        if (userName.includes(searchQuery)) {
          user.style.display = 'block'; 
        } else {
          user.style.display = 'none';
        }
      });
    });
  });
  
  