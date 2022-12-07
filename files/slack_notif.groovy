import java.text.SimpleDateFormat
def dateFormat
def date 
def formattedDate

def notifyPipeline (String buildStatus = 'STARTED') {
   buildStatus = buildStatus ?: 'SUCCESS'

   def dateTime = dateFormatted()
   def colorCode = '#FF0000'
   def summary = "${buildStatus} : Job Name '${env.JOB_NAME} | Build Number [${env.BUILD_NUMBER}] | URL : ${env.BUILD_URL} | Time : ${dateTime}'"

   if (buildStatus == 'STARTED') {
      colorCode = '#FFFF00'
   } else if (buildStatus == 'SUCCESS') {
      colorCode = '#00FF00'
   } else if (buildStatus == 'FAILURE') {
      colorCode = '#FF0000'
   } else {
      colorCode = '#FFA500'
   }

   slackSend (color: colorCode, channel: params.SLACK, message: summary)
}

def envDevStart (String buildStatus = 'STARTED') {
   buildStatus = buildStatus ?: 'SUCCESS'

   def dateTime = dateFormatted()
   def colorCode = '#FF0000'
   def summary = "Dev Env Run = ${buildStatus} : Job Name '${env.JOB_NAME} | Build Number [${env.BUILD_NUMBER}] | URL : ${env.BUILD_URL} | Time : ${dateTime}'"

   if (buildStatus == 'STARTED') {
      colorCode = '#FFFF00'
   } else if (buildStatus == 'SUCCESS') {
      colorCode = '#00FF00'
   } else if (buildStatus == 'FAILURE') {
      colorCode = '#FF0000'
   } else {
      colorCode = '#FFA500'
   }

   slackSend (color: colorCode, channel: params.SLACK, message: summary)
}

def envDevDeploy (String buildStatus) {
   buildStatus = buildStatus

   def dateTime = dateFormatted()
   def colorCode = '#FF0000'
   def summary = "Deploy on dev env success = ${buildStatus} : Job Name '${env.JOB_NAME} | Build Number [${env.BUILD_NUMBER}] | URL : ${env.BUILD_URL} | Time : ${dateTime}'"

   if (buildStatus == 'STARTED') {
      colorCode = '#FFFF00'
   } else if (buildStatus == 'SUCCESS') {
      colorCode = '#00FF00'
   } else if (buildStatus == 'FAILURE') {
      colorCode = '#FF0000'
   } else {
      colorCode = '#FFA500'
   }

   slackSend (color: colorCode, channel: params.SLACK, message: summary)
}

def envProdStart (String buildStatus) {
   buildStatus = buildStatus

   def dateTime = dateFormatted()
   def colorCode = '#FF0000'
   def summary = "Prod Env run = ${buildStatus} : Job Name '${env.JOB_NAME} | Build Number [${env.BUILD_NUMBER}] | URL : ${env.BUILD_URL} | Time : ${dateTime}'"

   if (buildStatus == 'STARTED') {
      colorCode = '#FFFF00'
   } else if (buildStatus == 'SUCCESS') {
      colorCode = '#00FF00'
   } else if (buildStatus == 'FAILURE') {
      colorCode = '#FF0000'
   } else {
      colorCode = '#FFA500'
   }

   slackSend (color: colorCode, channel: params.SLACK, message: summary)
}

def packerBuild (String buildStatus = 'STARTED') {
   buildStatus = buildStatus

   def dateTime = dateFormatted()
   def colorCode = '#FF0000'
   def summary = "Packer AMI Run = ${buildStatus} : Job Name '${env.JOB_NAME} | Build Number [${env.BUILD_NUMBER}] | URL : ${env.BUILD_URL} | Time : ${dateTime}'"

   if (buildStatus == 'STARTED') {
      colorCode = '#FFFF00'
   } else {
      colorCode = '#FFA500'
   }

   slackSend (color: colorCode, channel: params.SLACK, message: summary)
}

def dateFormatted () {
  dateFormat = new SimpleDateFormat("yyyy-MM-dd'|'HH:mm:ss")
  date = new Date()
  formattedDate = dateFormat.format(date)
  return formattedDate
}

def requireApproval() {
  def dateTime = dateFormatted()
  def colorCode = '#0000FF'
  def message = "[APPROVAL REQUIRED] JOB NAME : ${env.JOB_NAME} with BUILD NUMBER : ${env.BUILD_NUMBER} - URL : ${env.BUILD_URL} - Time : ${dateTime}"

  slackSend (color: colorCode, channel: params.SLACK, message: message)
}

return this

