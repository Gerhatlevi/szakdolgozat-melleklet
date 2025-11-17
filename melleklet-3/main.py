import base64
import json
import smtplib
import os
import functions_framework
from google.cloud import secretmanager
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

def access_secret(secret_path):
    client = secretmanager.SecretManagerServiceClient()
    response = client.access_secret_version(name=secret_path)
    return response.payload.data.decode("UTF-8")

@functions_framework.cloud_event
def main(cloud_event):
    """
    Triggered from a message on a Pub/Sub topic.
    """
    pubsub_message = cloud_event.data.get("message", {})
    encoded_data = pubsub_message.get("data")

    if not encoded_data:
        print("Missing data field in Pub/Sub message")
        return
    
    payload = base64.b64decode(encoded_data).decode("utf-8")
    data = json.loads(payload)

    raw_email = data.get("email")
    status = data.get("status")
    msg = data.get("msg", "")
    project = data.get("project", "")
    
    email = raw_email.replace("_at_", "@").replace("_dot_", ".")
    print(f"Build status received: email={email}, status={status}, msg={msg}, project={project}")

    subject = f"Build status: {status}"
    body = f"Hello,\n\nYour build has finished with status: {status}\nMessage: {msg}\nProject: {project}\n\nRegards,\nXxx Team"

    sender_email = "test@gmail.com"
    sender_password = access_secret(os.environ["GMAIL_APP_PASSWORD"])
    receiver_email = email
    sender_name = "Xxx Team"

    message = MIMEMultipart()
    message["From"] = f"{sender_name} <{sender_email}>"
    message["To"] = receiver_email
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    try:
        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as server:
            server.login(sender_email, sender_password)
            server.sendmail(sender_email, receiver_email, message.as_string())
        print(f"Email sent to {receiver_email}")
    except Exception as e:
        print(f"Failed to send email: {e}")
