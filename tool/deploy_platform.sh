#!/bin/sh

flutter build web --web-renderer canvaskit -t lib/main_platform.dart
firebase deploy --only hosting:platform
