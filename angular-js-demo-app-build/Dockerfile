# Step 1: Use nginx image
FROM nginx:alpine

# Step 2: Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Step 3: Copy AngularJS app into nginx html folder
COPY app /usr/share/nginx/html

# Step 4: Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Step 5: Expose port
EXPOSE 80

# Step 6: Start nginx
CMD ["nginx", "-g", "daemon off;"]
