# TorrentParser - a GUI application in Objective-C to parse BitTorrent files

The application will expose the following pieces of information (when available in the file):
- Torrent file name
- Description (comment)
- Creation date (creation date)
- Client that created the file (created by)
- The tracker URL (announce)
- The name, length and checksum of each file described in the torrent info

Features:
- Unit tests of parsing .torrent files and bencode are included.
- Open single or multiple files
- Error message for invalid files
- Split view to show both list and detail of files
