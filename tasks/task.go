package tasks

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/hibiken/asynq"
	"go.uber.org/zap"
	"vgo/core/log"
)

const (
	TestDelivery = "test:task"
)

type TestDeliveryPayload struct {
	UserID     int
	TemplateID string
}

func NewTestDelivery(userID int, tmplID string) (*asynq.Task, error) {
	payload, err := json.Marshal(TestDeliveryPayload{UserID: userID, TemplateID: tmplID})
	if err != nil {
		return nil, err
	}
	return asynq.NewTask(TestDelivery, payload), nil
}

func HandleTestDeliveryTask(ctx context.Context, t *asynq.Task) error {
	var p TestDeliveryPayload
	if err := json.Unmarshal(t.Payload(), &p); err != nil {
		log.GetLogger().Error("json.Unmarshal failed: %v", zap.Any("task-err", err), zap.Any("task-asynq", asynq.SkipRetry))
	}
	log.GetLogger().Info(fmt.Sprintf("Sending Email to User: user_id=%d, template_id=%s", p.UserID, p.TemplateID))
	return nil
}
