import os
import json

def ensure_airport(feature, path):

	if not os.path.exists(path):

            sfom_props = {
                        "sfomuseum:placetype": "airport",
                        "sfomuseum:is_sfo": 0,
                        "sfomuseum:airport_id": -1,
            }

            root = os.path.dirname(path)

            if not os.path.exists(root):
                 os.makedirs(root, 0755)
                        
            fh = open(path, "w")
            json.dump(sfom_props, fh, indent=2)
            fh.close()

            return

     # fh = open(path, "r")
     # sfom_props = json.load(fh)
