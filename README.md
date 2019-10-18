# Climbing Grade Conversion Tool

On vacation in Italy climbing grades are French, at home they are UIAA, and back in the states they
are YDS, so I built this tool as a quick reference. Also another chance to explore elm and
functional programming on the frontend.

* [Figma Mock-ups](https://www.figma.com/file/5rNgExOGBlQuSvbEdQP0Lm/Climbing-Grade-Conversion-Tool)
* [Design inspiration](https://www.are.na/travis-shears/playful-ui)
* [Climbing grade references](https://www.are.na/travis-shears/climbing-grades)

## Dev env

This project was bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).
Reference that doc for most things.

*Start dev_env with:*  
`$ elm-app start`

*Build for production into /build folder:*  
`$ elm-app start`

*Install elm packages with:*  
`$ elm-app install <package-name>`


### Installing JavaScript packages

To use JavaScript packages from npm, you'll need to add a `package.json`, install the dependencies, and you're ready to go.

```sh
npm init -y # Add package.json
npm install --save-dev pouchdb-browser # Install library from npm
```

```js
// Use in your JS code
import PouchDB from 'pouchdb-browser';
const db = new PouchDB('mydb');
```

## Production

Currently production is hosted in AWS with files in s3 bucket, domain DNS in route 53, and cloud
front caching connecting the two. In the future I'd like to get this into terriform for its more
reproducible.

