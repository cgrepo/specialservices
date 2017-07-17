json.extract! request, :id, :case, :rdate, :sent_by, :oriented, :service, :notes, :qualification, :person_id, :created_at, :updated_at
json.url request_url(request, format: :json)
