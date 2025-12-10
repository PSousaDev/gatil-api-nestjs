/*
  Warnings:

  - You are about to drop the column `birth_date` on the `cat` table. All the data in the column will be lost.
  - You are about to drop the column `breed` on the `cat` table. All the data in the column will be lost.
  - You are about to drop the column `height` on the `cat` table. All the data in the column will be lost.
  - You are about to drop the column `pedigree_number` on the `cat` table. All the data in the column will be lost.
  - The `status` column on the `data_import` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `veterinarian` on the `medical_record` table. All the data in the column will be lost.
  - You are about to drop the column `file_path` on the `post_media` table. All the data in the column will be lost.
  - The `status` column on the `social_post` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `adapter` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `staffing` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `temperament` to the `cat` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `event_type` on the `cat_event` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `file_key` to the `post_media` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Temperament" AS ENUM ('FRIENDLY', 'SHY', 'PLAYFUL', 'AGGRESSIVE', 'CURIOUS');

-- CreateEnum
CREATE TYPE "EventType" AS ENUM ('VACCINATION', 'CHECKUP', 'SURGERY', 'ADOPTION', 'GROOMING', 'OTHER', 'DEATH');

-- CreateEnum
CREATE TYPE "dataImportStatus" AS ENUM ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'FAILED');

-- CreateEnum
CREATE TYPE "POST_STATUS" AS ENUM ('DRAFT', 'SCHEDULED', 'PUBLISHED', 'FAILED');

-- DropForeignKey
ALTER TABLE "adapter" DROP CONSTRAINT "adapter_user_id_fkey";

-- DropForeignKey
ALTER TABLE "adopter" DROP CONSTRAINT "adopter_adapter_id_fkey";

-- DropForeignKey
ALTER TABLE "staffing" DROP CONSTRAINT "staffing_user_id_fkey";

-- AlterTable
ALTER TABLE "cat" DROP COLUMN "birth_date",
DROP COLUMN "breed",
DROP COLUMN "height",
DROP COLUMN "pedigree_number",
ADD COLUMN     "estimated_age" TIMESTAMP(3),
ADD COLUMN     "temperament" "Temperament" NOT NULL;

-- AlterTable
ALTER TABLE "cat_event" DROP COLUMN "event_type",
ADD COLUMN     "event_type" "EventType" NOT NULL;

-- AlterTable
ALTER TABLE "data_import" DROP COLUMN "status",
ADD COLUMN     "status" "dataImportStatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "medical_record" DROP COLUMN "veterinarian";

-- AlterTable
ALTER TABLE "post_media" DROP COLUMN "file_path",
ADD COLUMN     "file_key" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "social_post" DROP COLUMN "status",
ADD COLUMN     "status" "POST_STATUS" NOT NULL DEFAULT 'DRAFT';

-- DropTable
DROP TABLE "adapter";

-- DropTable
DROP TABLE "staffing";
