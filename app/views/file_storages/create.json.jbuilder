json.extract! @file, :id, :file_name, :comment_id
json.file do 
  json.url @file.file.url
end