-- CreateTable
CREATE TABLE "adapter" (
    "id" TEXT NOT NULL,
    "user_id" TEXT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "cpf" TEXT,
    "city" TEXT,
    "state" TEXT,
    "bio" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "bio_approved" BOOLEAN NOT NULL DEFAULT false,
    "phone_2" TEXT,
    "other_phones" TEXT,
    "address" TEXT,
    "n_adoptions_failed" INTEGER NOT NULL DEFAULT 0,
    "verification_date" TIMESTAMP(3),

    CONSTRAINT "adapter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adopter" (
    "id" TEXT NOT NULL,
    "user_id" TEXT,
    "adapter_id" TEXT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone_primary" TEXT NOT NULL,
    "city" TEXT,
    "state" TEXT,
    "bio" TEXT,
    "cpf" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "verification_date" TIMESTAMP(3),
    "adoption_agreement" BOOLEAN NOT NULL DEFAULT false,
    "adoption_returned" BOOLEAN NOT NULL DEFAULT false,
    "address" TEXT,
    "phone_2" TEXT,

    CONSTRAINT "adopter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adoption" (
    "id" TEXT NOT NULL,
    "cat_id" TEXT NOT NULL,
    "adopter_id" TEXT NOT NULL,
    "adoption_date" TIMESTAMP(3) NOT NULL,
    "return_date" TIMESTAMP(3),
    "return_reason" TEXT,
    "is_returned" BOOLEAN NOT NULL DEFAULT false,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "adoption_type" TEXT NOT NULL DEFAULT 'standard',
    "fee" DECIMAL(10,2),

    CONSTRAINT "adoption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cat" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "family" TEXT,
    "carriage" TEXT,
    "pedigree_number" TEXT,
    "breed" TEXT,
    "color" TEXT,
    "gender" TEXT,
    "birth_date" TIMESTAMP(3),
    "entry_date" TIMESTAMP(3),
    "microchip_id" TEXT,
    "microchip_date" TIMESTAMP(3),
    "vaccination_status" TEXT,
    "weight" DECIMAL(5,2),
    "height" DECIMAL(5,2),
    "status" TEXT,
    "is_neutered" BOOLEAN NOT NULL DEFAULT false,
    "is_available" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "description" TEXT,
    "special_needs" TEXT,

    CONSTRAINT "cat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cat_event" (
    "id" TEXT NOT NULL,
    "cat_id" TEXT NOT NULL,
    "event_type" TEXT NOT NULL,
    "title" TEXT,
    "description" TEXT,
    "event_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "cat_event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cat_photo" (
    "id" TEXT NOT NULL,
    "cat_id" TEXT NOT NULL,
    "file_path" TEXT NOT NULL,
    "file_name" TEXT NOT NULL,
    "file_size" INTEGER NOT NULL,
    "uploaded_by" TEXT,
    "uploaded_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_primary" BOOLEAN NOT NULL DEFAULT false,
    "mime_type" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "cat_photo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "data_import" (
    "id" TEXT NOT NULL,
    "file_name" TEXT NOT NULL,
    "file_path" TEXT NOT NULL,
    "file_size" INTEGER NOT NULL,
    "import_type" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "total_records" INTEGER NOT NULL DEFAULT 0,
    "successful_records" INTEGER NOT NULL DEFAULT 0,
    "failed_records" INTEGER NOT NULL DEFAULT 0,
    "error_log" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "completed_at" TIMESTAMP(3),

    CONSTRAINT "data_import_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "medical_record" (
    "id" TEXT NOT NULL,
    "cat_id" TEXT NOT NULL,
    "user_id" TEXT,
    "record_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "record_type" TEXT NOT NULL,
    "diagnosis" TEXT,
    "treatment" TEXT,
    "notes" TEXT,
    "next_appointment" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "veterinarian" TEXT,
    "medication" TEXT,
    "dosage" TEXT,
    "duration" TEXT,

    CONSTRAINT "medical_record_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permission" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "resources" TEXT,
    "action" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "post_cat" (
    "id" TEXT NOT NULL,
    "post_id" TEXT NOT NULL,
    "cat_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "post_cat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "post_media" (
    "id" TEXT NOT NULL,
    "post_id" TEXT NOT NULL,
    "media_type" TEXT NOT NULL,
    "file_path" TEXT NOT NULL,
    "file_name" TEXT NOT NULL,
    "file_size" INTEGER NOT NULL,
    "mime_type" TEXT NOT NULL,
    "order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "alt" TEXT,
    "display_order" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "post_media_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_permission" (
    "id" TEXT NOT NULL,
    "role_id" TEXT NOT NULL,
    "permission_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "role_permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "social_post" (
    "id" TEXT NOT NULL,
    "user_id" TEXT,
    "title" VARCHAR(500) NOT NULL,
    "platform" VARCHAR(100) NOT NULL,
    "content" TEXT,
    "hashtags" TEXT,
    "scheduled_date" TIMESTAMP(3),
    "published_date" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'draft',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "internal_post_id" TEXT,
    "external_post_id" TEXT,
    "is_featured" BOOLEAN NOT NULL DEFAULT false,
    "view_count" INTEGER NOT NULL DEFAULT 0,
    "likes" INTEGER NOT NULL DEFAULT 0,
    "comments" INTEGER NOT NULL DEFAULT 0,
    "shares" INTEGER NOT NULL DEFAULT 0,
    "engagement_rate" DECIMAL(5,2),

    CONSTRAINT "social_post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "staffing" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "email_type" TEXT NOT NULL,
    "mailing_lists" TEXT,
    "mailing_frequency" TEXT,
    "subscribed" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "receive_newsletter" BOOLEAN NOT NULL DEFAULT true,
    "receive_alerts" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "staffing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "bio" TEXT,
    "verified_by" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_role" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "role_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_role_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "adapter_email_key" ON "adapter"("email");

-- CreateIndex
CREATE UNIQUE INDEX "adapter_cpf_key" ON "adapter"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "adopter_email_key" ON "adopter"("email");

-- CreateIndex
CREATE UNIQUE INDEX "adopter_cpf_key" ON "adopter"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "permission_name_key" ON "permission"("name");

-- CreateIndex
CREATE UNIQUE INDEX "post_cat_post_id_cat_id_key" ON "post_cat"("post_id", "cat_id");

-- CreateIndex
CREATE UNIQUE INDEX "role_name_key" ON "role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "role_permission_role_id_permission_id_key" ON "role_permission"("role_id", "permission_id");

-- CreateIndex
CREATE UNIQUE INDEX "staffing_user_id_key" ON "staffing"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_role_user_id_role_id_key" ON "user_role"("user_id", "role_id");

-- AddForeignKey
ALTER TABLE "adapter" ADD CONSTRAINT "adapter_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adopter" ADD CONSTRAINT "adopter_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adopter" ADD CONSTRAINT "adopter_adapter_id_fkey" FOREIGN KEY ("adapter_id") REFERENCES "adapter"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adoption" ADD CONSTRAINT "adoption_cat_id_fkey" FOREIGN KEY ("cat_id") REFERENCES "cat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "adoption" ADD CONSTRAINT "adoption_adopter_id_fkey" FOREIGN KEY ("adopter_id") REFERENCES "adopter"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cat_event" ADD CONSTRAINT "cat_event_cat_id_fkey" FOREIGN KEY ("cat_id") REFERENCES "cat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cat_photo" ADD CONSTRAINT "cat_photo_cat_id_fkey" FOREIGN KEY ("cat_id") REFERENCES "cat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cat_photo" ADD CONSTRAINT "cat_photo_uploaded_by_fkey" FOREIGN KEY ("uploaded_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medical_record" ADD CONSTRAINT "medical_record_cat_id_fkey" FOREIGN KEY ("cat_id") REFERENCES "cat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "medical_record" ADD CONSTRAINT "medical_record_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post_cat" ADD CONSTRAINT "post_cat_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "social_post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post_cat" ADD CONSTRAINT "post_cat_cat_id_fkey" FOREIGN KEY ("cat_id") REFERENCES "cat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "post_media" ADD CONSTRAINT "post_media_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "social_post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permission" ADD CONSTRAINT "role_permission_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permission" ADD CONSTRAINT "role_permission_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "permission"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "social_post" ADD CONSTRAINT "social_post_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "staffing" ADD CONSTRAINT "staffing_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_role" ADD CONSTRAINT "user_role_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_role" ADD CONSTRAINT "user_role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON DELETE CASCADE ON UPDATE CASCADE;
