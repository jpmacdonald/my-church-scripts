package main

import (
	"encoding/base64"
	"fmt"
	"io/ioutil"
	"os"
	"os/user"
	"path/filepath"
	"regexp"
	"runtime"
	"strings"
)

func main() {
	user, err := user.Current()
	check(err)

	path := ""
	switch runtime.GOOS {
	case "windows":
		path = "C:\\Users\\" + user.Username + "\\Documents\\ProPresenter6\\"
	case "darwin":
		path = "/Users/" + user.Username + "/Documents/ProPresenter6/"
	}
	if path == "" {
		fmt.Println("Are you on Windows/MacOS?")
		os.Exit(1)
	}
	files, err := filepath.Glob(path + "*.pro6")
	check(err)

	for _, f := range files {
		trim(f)
	}

	fmt.Println("Newlines trimmed.")
}

func trim(path string) {

	read, err := ioutil.ReadFile(path)
	check(err)

	contents := string(read)

	re := regexp.MustCompile(`"RTFData">(.*?)<`)
	matches := re.FindAllStringSubmatch(contents, -1)
	for _, match := range matches {
		fmt.Println(match)
		encoded := match[1]
		decoded, err := base64.StdEncoding.DecodeString(encoded)
		check(err)
		decodedStr := string(decoded)
		re = regexp.MustCompile(`\\\s+}`)
		decodedStr = re.ReplaceAllString(decodedStr, "}")
		contents = strings.ReplaceAll(contents, encoded, base64.StdEncoding.EncodeToString([]byte(decodedStr)))
	}

	err = ioutil.WriteFile(path, []byte(contents), 0)
	check(err)
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}
