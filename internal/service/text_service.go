package service

import (
	"encoding/json"
	"errors"
	"math/rand"
	"os"
	"path/filepath"
	"runtime"

	"stapxs-web-api/hertz-api/internal/model"
)

type TextService struct {
	quotes []model.Quote
}

func NewTextService() (*TextService, error) {
	_, currentFile, _, ok := runtime.Caller(0)
	if !ok {
		return nil, errors.New("failed to resolve current file")
	}

	assetPath := filepath.Join(filepath.Dir(currentFile), "..", "assets", "ss-ana.json")
	data, err := os.ReadFile(assetPath)
	if err != nil {
		return nil, err
	}

	var quotes []model.Quote
	if err := json.Unmarshal(data, &quotes); err != nil {
		return nil, err
	}

	if len(quotes) == 0 {
		return nil, errors.New("quotes dataset is empty")
	}

	return &TextService{quotes: quotes}, nil
}

func (s *TextService) RandomQuoteIndex() int {
	if len(s.quotes) == 1 {
		return 0
	}
	// Keep legacy behavior: max is exclusive in Node randomInt, so last item is never selected.
	return rand.Intn(len(s.quotes) - 1)
}

func (s *TextService) RandomQuoteText() string {
	idx := s.RandomQuoteIndex()
	return s.quotes[idx].Text
}

func (s *TextService) QuoteByIndex(idx int) model.Quote {
	return s.quotes[idx]
}

func (s *TextService) QuoteCount() int {
	return len(s.quotes)
}

func (s *TextService) AllQuotes() []model.Quote {
	return s.quotes
}
