--- slice.rb	2008-03-08 14:56:15.000000000 +0100
+++ slice1.rb	2008-04-18 10:38:45.000000000 +0200
@@ -5,7 +5,7 @@
   def slice(*keep_keys)
     h = {}
     keep_keys.each do |key|
-      h[key] = fetch(key)
+      h[key] = self[key]
     end
     h
   end
