## Laravel Rest API - Email Service
This Example Implementation `Laravel Rest API - Send Email Service`, for Microservice Architecture

## How To Run
- Create & Configure `.env` from `.env.example`
- Install Package `composer install`
- Run Server `php artisan serve`
- Happy Coding 👊

## Routes
```
POST /api/send-email
@body: name, body, recipient_email, recipient_name, subject
```