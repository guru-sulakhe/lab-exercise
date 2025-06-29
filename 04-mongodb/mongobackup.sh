DB_NAME="myNewDatabase" # Replace with your MongoDB database name
COLLECTION_NAME="initCollection"
TIMESTAMP=$(date +%F-%H-%M-%S)
MONGO_HOST="localhost"
MONGO_PORT="27017"
S3_BUCKET="mongodb_backups"
BACKUP_DIR="/opt/mongodb_backups" #THis is location of the backup files are located in linux server
BACKUP_FILE="mongodb_backup_$TIMESTAMP.gz"
ARCHIVE_PATH="$BACKUP_DIR/$BACKUP_FILE"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2.. $R Failed $N"
    else
        echo -e "$2.. $G Successful $N" 
    fi   
}

if [ $USERID -ne 0 ]
then
    echo "you don't have access, only root-user can access the file, try to login in as root-user"
    exit 1 # manually exits if error
else
    echo "You are super-user"
fi

# Create Database and Insert Initial Document into Collection
mongo --host "$MONGO_HOST" --port "$MONGO_PORT" <<EOF
use $DB_NAME
db.$COLLECTION_NAME.insertOne({ initialized: true })
EOF

echo "MongoDB database '$DB_NAME' created with collection '$COLLECTION_NAME'"

# Ensure backup directory exists if not it will create new $BACKUP_DIR directory
mkdir -p "$BACKUP_DIR" 
VALIDATE $? "Creating BACKUP_DIRECTORY"
echo "Starting backup of MongoDB database: $DB_NAME"

# Perform backup and mongodump will create compressed gzip backup of the database, Output is stored in $ARCHIVE_PATH
mongodump --db="$DB_NAME" --archive="$ARCHIVE_PATH" --gzip

# Check for mongodump success
if [ $? -ne 0 ]; then
    echo "MongoDB backup failed."
    exit 1
else
    echo "Backup created: $ARCHIVE_PATH"
fi

# Uploads the backup file to the specified S3 bucket path using AWS CLI
echo "Uploading to S3..."
aws s3 cp "$ARCHIVE_PATH" "s3://$S3_BUCKET/mongo_backups/$BACKUP_FILE"

# Check for upload success
if [ $? -ne 0 ]; then
    echo "Failed to upload backup to S3."
    exit 1
else
    echo "Backup uploaded to s3://$S3_BUCKET/mongo_backups/$BACKUP_FILE"
fi

# Deletes .gz files older than 7 days in the backup directory
echo "Cleaning up old backups..."
find "$BACKUP_DIR" -type f -name "*.gz" -mtime +7 -exec rm {} \;

echo "MongoDB backup process completed successfully."
