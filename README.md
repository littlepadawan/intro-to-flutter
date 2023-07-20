# ToDo List
Assignment 2 in the Introduction to App Development with Flutter at Linnaeus University. 1DV535, 7.5 credits.

## About
A stateful Flutter application consisting of a simple to-do list. Focus when creating the application was input and lists, why there is nothing persistant in form of a database or saving data. 

### Requirements:
- Text can be entered and put in a scrollable list
- If an item is clicked, it is removed from the list and the item's text is set into the text field
- Following the above, the new text can be put last on the list

### Extra:
Leading checkboxes are added to the items. Clicking these will toggle styling of the item text - when checked, the item text will be crossed over.

### Potential bugs:
When running the app on Android Emulator on a laptop, the scrolling gesture seems to register as a click or tap. Resulting in removing items from the list instead of scrolling through it.

## Dependencies
Flutter and Android Studio. Navigate to root of project (*my_app*) and run `flutter run`.


## Preview
<img src="/my_app/images/todo_preview.png" alt="Preview of the app" width="200"/>
