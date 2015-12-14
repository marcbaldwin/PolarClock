# Polar Clock
A polar clock for iOS written in Swift.

## Description
The rings represent the components of the current time.

Color | Component
--- | ---  
Yellow | Second
Orange | Minute
Pink | Hour
Green | Day
Blue | Month
Purple | Year

## Animation
- When the app is first launched the rings are faded in and expanded to their initial positions
- The rings are animated to their positions as time progresses

## Demo
![demo](PolarClockDemo.gif)

## Dependencies

I used the following libraries for this project:

1. [`AsyncSwift`](http://github.com/duemunk/Async) - Scheduling tasks on UI queue
2. [`SwiftDate`](http://github.com/malcommac/SwiftDate) - Date and time components
3. [`AutoLayoutBuilder`](http://github.com/marcbaldwin/AutoLayoutBuilder) - Layout constraints
