ALTER TABLE "plumbing"."hs_ticket_to_linear_label" ALTER COLUMN "property_id" SET NOT NULL;
ALTER TABLE "plumbing"."hs_ticket_to_linear_label" ALTER COLUMN "property_label" SET NOT NULL;
ALTER TABLE "plumbing"."hs_ticket_to_linear_label" ALTER COLUMN "label" SET NOT NULL;
ALTER TABLE "plumbing"."hs_ticket_to_linear_label" ALTER COLUMN "linear_label_name" SET NOT NULL;
ALTER TABLE "plumbing"."hs_ticket_to_linear_label" ALTER COLUMN "linear_label_id" SET NOT NULL;
ALTER TABLE "plumbing"."hs_ticket_to_linear_label" ADD CONSTRAINT "hs_ticket_to_linear_label__idx" UNIQUE;