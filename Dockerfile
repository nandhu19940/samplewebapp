# We use nginx:alpine because it's tiny and professional
FROM nginx:alpine

# Copy your index.html from the GitHub repo (which Jenkins pulls) 
# into the web server folder inside the image
COPY index.html /usr/share/nginx/html/index.html

# Documentation to show this container listens on port 80
EXPOSE 80
