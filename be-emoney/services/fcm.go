package services

import (
	"context"
	"log"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/messaging"
)

type FCMService struct {
	app *firebase.App
}

func NewFCMService(app *firebase.App) *FCMService {
	return &FCMService{app: app}
}

func (s *FCMService) Notify(ctx context.Context, fcmToken, title, body string, data map[string]string) {
	if fcmToken == "" {
		return
	}
	client, err := s.app.Messaging(ctx)
	if err != nil {
		log.Printf("FCM: messaging client error: %v", err)
		return
	}
	_, err = client.Send(ctx, &messaging.Message{
		Token: fcmToken,
		Notification: &messaging.Notification{
			Title: title,
			Body:  body,
		},
		Data: data,
		Android: &messaging.AndroidConfig{
			Priority: "high",
			Notification: &messaging.AndroidNotification{
				ChannelID: "transactions",
			},
		},
	})
	if err != nil {
		log.Printf("FCM: send error: %v", err)
	}
}
