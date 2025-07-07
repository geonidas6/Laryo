<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use NotificationChannels\Fcm\FcmMessage;
use NotificationChannels\Fcm\Resources\Notification as FcmNotificationResource;

class FcmNotification extends Notification
{
    use Queueable;

    public function __construct(private string $title, private string $body)
    {
    }

    public function via(object $notifiable): array
    {
        return ['fcm'];
    }

    public function toFcm(object $notifiable): FcmMessage
    {
        return FcmMessage::create()->setNotification(
            FcmNotificationResource::create()
                ->setTitle($this->title)
                ->setBody($this->body)
        );
    }
}
