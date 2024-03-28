#!/usr/bin/env python3

import os
import subprocess
import hashlib
import logging
from urllib.parse import quote
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class ThumbnailGenerator:
    def __init__(self, directory):
        self.directory = directory
        self.thumbnail_sizes = {'normal': 128, 'large': 256, 'x-large': 512}
        self.setup_logging()

    def setup_logging(self):
        logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

    def generate_thumbnail(self, filename):
        file_uri = f'file://{quote(os.path.abspath(filename))}'
        hash_md5 = hashlib.md5(file_uri.encode('utf-8')).hexdigest()

        for size_name, size in self.thumbnail_sizes.items():
            thumbnail_dir = os.path.expanduser(f'~/.cache/thumbnails/{size_name}')
            os.makedirs(thumbnail_dir, exist_ok=True)
            thumbnail_path = os.path.join(thumbnail_dir, f'{hash_md5}.png')

            if os.path.exists(thumbnail_path) and os.path.getmtime(thumbnail_path) >= os.path.getmtime(filename):
                continue

            command = f'/usr/bin/gdk-pixbuf-thumbnailer -s {size} "{filename}" "{thumbnail_path}"'
            subprocess.run(command, shell=True)
            logging.info(f'Generated thumbnail for {filename} at {thumbnail_path}')

    def process_existing_files(self):
        for root, _, files in os.walk(self.directory):
            for filename in files:
                self.generate_thumbnail(os.path.join(root, filename))

    def run(self):
        self.process_existing_files()
        event_handler = FileSystemEventHandler()
        event_handler.on_created = lambda event: self.generate_thumbnail(event.src_path)
        event_handler.on_modified = lambda event: self.generate_thumbnail(event.src_path)

        observer = Observer()
        observer.schedule(event_handler, self.directory, recursive=True)
        observer.start()

        try:
            while True:
                observer.join(1)
        except KeyboardInterrupt:
            observer.stop()
        observer.join()

if __name__ == "__main__":
    generator = ThumbnailGenerator(os.path.expanduser('~/Pictures'))
    generator.run()

