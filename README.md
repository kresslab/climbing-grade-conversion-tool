# Climbing Grade Conversion Tool

On vacation in Italy climbing grades are French, at home they are UIAA, and back in the states they
are YDS, so I built this tool as a quick reference. Also another chance to explore elm and
functional programming on the frontend.

* [Figma Mock-ups](https://www.figma.com/file/5rNgExOGBlQuSvbEdQP0Lm/Climbing-Grade-Conversion-Tool)
* [Design inspiration](https://www.are.na/travis-shears/playful-ui)
* [Climbing grade references](https://www.are.na/travis-shears/climbing-grades)

## Screenshots

![tool screenshot](./climbing-grade-conversion-tool-screenshot.png)

## Dev env

This project was bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).
Reference that doc for most things.

*Start dev_env with:*  
`$ elm-app start`

*Build for production into /build folder:*  
`$ elm-app start`

*Install elm packages with:*  
`$ elm-app install <package-name>`


## Contributions

Special thanks to @kressnick25 for adding the Ewbank grading system,
[commit](https://github.com/BTBTravis/climbing-grade-conversion-tool/commit/8ff5c3d751516ba6ed6a465cdc3053a408843429)

## Production

Currently production is hosted in AWS with files in s3 bucket, domain DNS in route 53, and cloud
front caching connecting the two. In the future I'd like to get this into terriform for its more
reproducible.

### Deploying to production

- `$ make` will build files into ./build folder
- `$ make deploy` will build then push files to aws

## TODO

- [X] script building
- [X] script deployment
- [X] style for mobile
- [ ] add missing climbing grades
- [ ] bouldering grades?
    - colors of holds at local gyms converted?
    - rotating 3D hold models colored for difficulty?
    - separate site?
    - different tech?
