package users

import (
	"bytes"
	"net/http"
	"net/http/httptest"
	"os"
	"realworld-backend/common"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"github.com/stretchr/testify/assert"
)

var image_url = "https://golang.org/doc/gopher/frontpage.png"
var test_db *gorm.DB
var unauthRequestTests = []struct {
	init           func(*http.Request)
	url            string
	method         string
	bodyData       string
	expectedCode   int
	responseRegexg string
	msg            string
}{}

func TestWithoutAuth(t *testing.T) {
	asserts := assert.New(t)
	//You could write the reset database code here if you want to create a database for this block
	//resetDB()

	r := gin.New()
	UsersRegister(r.Group("/users"))
	r.Use(AuthMiddleware(true))
	UserRegister(r.Group("/user"))
	ProfileRegister(r.Group("/profiles"))
	for _, testData := range unauthRequestTests {
		bodyData := testData.bodyData
		req, err := http.NewRequest(testData.method, testData.url, bytes.NewBufferString(bodyData))
		req.Header.Set("Content-Type", "application/json")
		asserts.NoError(err)

		testData.init(req)

		w := httptest.NewRecorder()
		r.ServeHTTP(w, req)

		asserts.Equal(testData.expectedCode, w.Code, "Response Status - "+testData.msg)
		asserts.Regexp(testData.responseRegexg, w.Body.String(), "Response Content - "+testData.msg)
	}
}

// This is a hack way to add test database for each case, as whole test will just share one database.
// You can read TestWithoutAuth's comment to know how to not share database each case.
func TestMain(m *testing.M) {
	test_db = common.TestDBInit()
	AutoMigrate()
	exitVal := m.Run()
	common.TestDBFree(test_db)
	os.Exit(exitVal)
}
